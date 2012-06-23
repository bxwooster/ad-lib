#include <assert.h>
#include <stdlib.h>
#include <sys/queue.h>
#include <wrap/windows.h>
#include "hot.h"

#pragma warning (disable : 4127) /* conditional expression is constant */
/* needed because TAILQ uses some peculiar constructions in its macros */

struct item {
	void * data;
	const char * file;
	hot_loader_t loader;
	TAILQ_ENTRY(item) _;
};

HANDLE __handle = INVALID_HANDLE_VALUE;
TAILQ_HEAD(head, item) * __list = NULL;

void hotinit () {
	__list = (head *) malloc (sizeof (*__list));
	assert (__list != NULL);
	TAILQ_INIT (__list);

	char dir [1024];
	assert (GetCurrentDirectory (sizeof (dir), dir));
	__handle = FindFirstChangeNotification (dir, FALSE, FILE_NOTIFY_CHANGE_LAST_WRITE);
	assert (__handle != INVALID_HANDLE_VALUE);
}

hot_handle_t hotload (
	void * data,
	const char * file,
	hot_loader_t loader
) {
	if (loader (data, file) != 0) {
		return (NULL);
	}

	struct item * item = (struct item *) malloc (sizeof (*item));
	assert (item != NULL);

	item->data = data;
	item->file = file;
	item->loader = loader;
	TAILQ_INSERT_TAIL (__list, item, _);

	return (item);
}

int hotcheck () {
	int errors = 0;

	if (WaitForSingleObject (__handle, 0) == WAIT_OBJECT_0) {
		FindNextChangeNotification(__handle);
		struct item * item;
		TAILQ_FOREACH (item, __list, _) {
			if (item->loader (item->data, item->file)) {
				errors++;
			}
		}
	}

	return (errors);
}

void hotfin () {
	struct item * item;
	struct item * tvar;
	TAILQ_FOREACH_SAFE (item, __list, _, tvar) {
		free (item);
	}
	free (__list);
}
