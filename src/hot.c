#include <assert.h>
#include <stdlib.h>
#include "sys/queue.h"
#include "hot.h"

struct item {
	void * data;
	char const * file;
	hot_loader_t loader;
	TAILQ_ENTRY(item) _;
};

TAILQ_HEAD(head, item) * __list = NULL;

void hotinit () {
	__list = (struct head *) malloc (sizeof (*__list));
	assert (__list != NULL);
	TAILQ_INIT (__list);
}

hot_handle_t hotload (
	void * data,
	char const * file,
	hot_loader_t loader
) {
	int error;

	if ((error = loader (data, file)) != 0) {
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

