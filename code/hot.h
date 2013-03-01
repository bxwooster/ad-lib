/* real hot stuff */

SOCKET hot_player_socket (void);
SOCKET hot_server_socket (void);

void hot_serve (SOCKET real);
/* non-blocking. does everything that's pending */
/* right now will block if socket has no incoming data */

char * hot_play (SOCKET real, char * filename);
/* temporary */

/*************************/
/* the real stuff begins */
/*************************/

struct hot_player;

typedef void (*hot_callback) (void *, char *);

struct hot_player * hot_new_player (void);

void hot_del_player (struct hot_player * H);

uint32_t hot_pull (struct hot_player * H,
        char * filename, hot_callback call, void * data);

uint32_t hot_pull_test (struct hot_player * H,
        char * filename, hot_callback call, void * data);
