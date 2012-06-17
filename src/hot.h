typedef int (* __hot_loader_t) (void *, char const *);
typedef void * hot_handle_t;

void hot_init ();
int hot_check ();

hot_handle_t hot_load (
	void * data,
	char const * file,
	__hot_loader_t loader
);
