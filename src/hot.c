#include <assert.h>
#include <stdlib.h>
#include <sys/queue.h>
#include "w_windows.h"
#include "common.h"
#include "hot.h"

#pragma warning (disable : 4127) /* conditional expression is constant */
/* needed because TAILQ uses some peculiar constructions in its macros */

struct item_t {
	void * data;
	const char * file;
	hot_t loader;
	TAILQ_ENTRY(item_t) _;
};

/*HANDLE __handle = INVALID_HANDLE_VALUE;*/
TAILQ_HEAD(head_t, item_t) * __list = NULL;

void hot_init () {
	__list = (head_t *) malloc (sizeof (*__list));
	assert (__list != NULL);
	TAILQ_INIT (__list);

	/*char dir [1024];
	GetCurrentDirectory (sizeof (dir), dir);
	__handle = FindFirstChangeNotification (dir, FALSE, FILE_NOTIFY_CHANGE_LAST_WRITE);*/
}

hot_handle_t hot_load (
	void * data,
	const char * file,
	hot_t loader
) {
	if (loader (data, file) != 0) {
		return (NULL);
	}

	struct item_t * item = (item_t *) malloc (sizeof (*item));
	assert (item != NULL);

	item->data = data;
	item->file = file;
	item->loader = loader;
	TAILQ_INSERT_TAIL (__list, item, _);

	return (item);
}

int hot_check () {
	int errors = 0;

	Sleep(10);
	/*if (WaitForSingleObject (__handle, 0) == WAIT_OBJECT_0) {*/
	struct item_t * item;
	TAILQ_FOREACH (item, __list, _) {
		if (item->loader (item->data, item->file)) {
			errors++;
		}
	}

	return (errors);
}