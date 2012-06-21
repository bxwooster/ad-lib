char const * quotes [] = {

"A purely objective viewpoint does not exist in the cosmos or in politics.",
"Cross cultural experience teaches us not simply that people have different beliefs, but that people seek meaning and understand themselves in some sense as members of a cosmos ruled by God.",
"For in the works of Robert Burns we see the whole cosmos of man's experience and emotion, from zenith to nadir, from birth until death.",
"God who is eternally complete, who directs the stars, who is the master of fates, who elevates man from his lowliness to Himself, who speaks from the cosmos to every single human soul, is the most brilliant manifestation of the goal of perfection.",
"However, the Bible is called the Word of God because the whole transcript is an inspired, faithful, and infallible record of what God determined essential for us to know about Himself, the cosmos in which we live, our spiritual allies and adversaries, and our fellow man.",
"I felt like I'd been misplaced in the cosmos and I belonged in Maine.",
"I look out of this window and I think this is a cosmos, this is a huge creation, this is one small corner of it. The trees and birds and everything else and I'm part of it. I didn't ask to be put here, I've been lucky in finding myself here.",
"I'm playing dark history. It's beyond black. I'm dealing with the dark things of the cosmos.",
"In all chaos there is a cosmos, in all disorder a secret order.",
"One may understand the cosmos, but never the ego; the self is more distant than any star.",
"Other times, you're doing some piece of work and suddenly you get feedback that tells you that you have touched something that is very alive in the cosmos.",
"Our dreams are firsthand creations, rather than residues of waking life. We have the capacity for infinite creativity; at least while dreaming, we partake of the power of the Spirit, the infinite Godhead that creates the cosmos.",
"Roger Revelle died of a heart attack three months after the Cosmos story was printed. Oh, how I wish he were still alive today. He might be able to stop this scientific silliness and end the global warming scam. He might well stand beside me as a global warming denier.",
"The cosmos is about the smallest hole that a man can hide his head in.",
"The most important scientific revolutions all include, as their only common feature, the dethronement of human arrogance from one pedestal after another of previous convictions about our centrality in the cosmos.",
"This is so American, man: either make something your God and cosmos and then worship it, or else kill it.",
"To the dumb question, why me? The cosmos barely bothers to return the reply: 'Why not.'",
"We are in the cosmos and the cosmos is in us.",
"We are the first generation of human beings to have substantial insights into the origin of our cosmos and of human life in it.",
"Whether you want to call it God or the mystery of the cosmos doesn't matter to me.",
"I am but one infinitesimal mote in the cosmos."

};

#include <time.h>
#include <stdlib.h>

char const * randomquote ()
{
	int const n = sizeof (quotes) / sizeof (quotes [0]);
	srand ((unsigned int) time (NULL));
	return ((rand () % n) [quotes]);
}