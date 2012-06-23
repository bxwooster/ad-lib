typedef int (* hot_loader_t) (void *, char const *);
typedef void * hot_handle_t;

void hotinit ();
int hotcheck ();
void hotfin ();

hot_handle_t hotload (
	void * data,
	char const * file,
	hot_loader_t loader
);
