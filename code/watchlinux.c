#define BUFSIZE ((sizeof (struct inotify_event) + FILENAME_MAX) * 4)
#define MAXSUB 32

/* Limitations at the moment:
 * - only 1 level of nested directories watched (inotify doesn't do recursive)
 * - MAXSUB nested directories overall
 */

struct watcher {
	int i;
	int w;
    char * buffer;
    struct subdir * sub;
	int subsize;
};

struct subdir {
	int w;
	char name [FILENAME_MAX];
};

struct watcher * watch_init (void) {
    struct watcher * W = malloc (sizeof (*W));
    OK (W != NULL);

    W->buffer = malloc (BUFSIZE);
    OK (W->buffer != NULL);

	W->sub = malloc (MAXSUB * sizeof (struct subdir));
	OK (W->sub != NULL);

	W->i = inotify_init1 (IN_NONBLOCK);
	OK (W->i >= 0);

	W->w = inotify_add_watch (W->i, ".", IN_CLOSE_WRITE);
	OK (W->w >= 0);

	DIR* dir = opendir (".");
	OK (dir != NULL);

	struct dirent * d;
	int i = 0;
	while((d = readdir (dir)) != NULL) {
		OK (i != MAXSUB);
		struct subdir * s = W->sub + i;
		if (d->d_name[0] == '.') continue;
		if (d->d_type != DT_DIR) continue;
		s->w = inotify_add_watch (W->i, d->d_name, IN_CLOSE_WRITE);
		strcpy (s->name, d->d_name);
		OK (s->w >= 0);

		i++;
	}
	W->subsize = i;

	closedir (dir);

    return W;
}

void watch_del (struct watcher * W) {
	inotify_rm_watch (W->i, W->w);
	for (int i = 0; i < W->subsize; ++i) {
		inotify_rm_watch (W->i, W->sub[i].w);
	}
	close (W->i);
	free (W->buffer);
    free (W);
}

void watch_update (struct watcher * W, watch_callback call, void * data) {
	ssize_t len = read (W->i, W->buffer, BUFSIZE);
	if (len == -1 && (errno == EAGAIN || errno == EWOULDBLOCK)) return;
	OK (len >= 0);
	for (ssize_t i = 0; i < len;) {
		struct inotify_event * ev = (void *) & W->buffer[i];
		if (ev->mask & IN_CLOSE_WRITE) {
			if (ev->wd == W->w) {
				call (data, ev->name);
			} else for (int i = 0; i < W->subsize; ++i) {
				struct subdir * s = W->sub + i;
				if (ev->wd == s->w) {
					char name [FILENAME_MAX * 2 + 1];
					snprintf (name, sizeof (name), "%s/%s", s->name, ev->name);
					call (data, name);
				}
			}
		}
		i += sizeof (*ev) + ev->len;
	}
}
