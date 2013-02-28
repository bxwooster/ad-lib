/* real hot stuff */

SOCKET hot_player (void);
SOCKET hot_server (void);

void hot_serve (SOCKET real);
/* non-blocking. does everything that's pending */
/* right now will block if socket has no incoming data */

char * hot_play (SOCKET real, char * filename);
/* temporary */
