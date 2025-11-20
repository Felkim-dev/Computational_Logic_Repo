sentence --> noun_phrase, verb_phrase.

noun_phrase --> adjectives, noun.
noun_phrase --> determiner,adjectives, noun.

verb_phrase --> verb, noun_phrase.

adjectives --> [].
adjectives --> adjective.
adjectives --> adjective, adjective.

determiner --> [the].
determiner --> [a].

noun --> [cat].
noun --> [dog].
noun --> [fish].
noun --> [bird].

verb --> [eats].
verb --> [sees].

adjective --> [big].
adjective --> [small].
adjective --> [angry].


% PARSING

% ?- phrase(sentence, [the, cat, eats, a, fish]).
% true .

% ?- phrase(sentence, [cat, eats, fish]).
% true .

% Generation

% X = [cat, eats, fish] ;
% X = [cat, eats, bird] ;
% X = [cat, eats, big, cat] ;
% X = [cat, eats, big, dog] ;
% X = [cat, eats, big, fish] ;
% X = [cat, eats, big, bird] ;
% X = [cat, eats, small, cat] ;
% X = [cat, eats, small, dog] ;
% X = [cat, eats, small, fish] ;
% X = [cat, eats, small, bird] ;
% X = [cat, eats, angry, cat] ;
% X = [cat, eats, angry, dog] ;
% X = [cat, eats, angry, fish] ;
% X = [cat, eats, angry, bird] ;
% X = [cat, eats, big, big, cat] ;
% X = [cat, eats, big, big, dog] ;
% X = [cat, eats, big, big, fish] ;
% X = [cat, eats, big, big, bird] ;
% X = [cat, eats, big, small, cat] ;
% X = [cat, eats, big, small, dog] ;
% X = [cat, eats, big, small, fish] ;
% X = [cat, eats, big, small, bird] ;
% X = [cat, eats, big, angry, cat] ;
% X = [cat, eats, big, angry, dog] ;
% X = [cat, eats, big, angry, fish] ;
% X = [cat, eats, big, angry, bird] ;
% X = [cat, eats, small, big, cat] ;
% X = [cat, eats, small, big, dog] ;
% X = [cat, eats, small, big, fish] ;
% X = [cat, eats, small, big, bird] ;
% X = [cat, eats, small, small, cat] ;
% X = [cat, eats, small, small, dog] ;
% X = [cat, eats, small, small, fish] ;
% X = [cat, eats, small, small, bird] ;
% X = [cat, eats, small, angry, cat] ;
% X = [cat, eats, small, angry, dog] ;
% X = [cat, eats, small, angry, fish] ;
% X = [cat, eats, small, angry, bird] ;
% X = [cat, eats, angry, big, cat] ;
% X = [cat, eats, angry, big, dog] ;
% X = [cat, eats, angry, big, fish] ;
% X = [cat, eats, angry, big, bird] ;
% X = [cat, eats, angry, small, cat] ;
% X = [cat, eats, angry, small, dog] ;
% X = [cat, eats, angry, small, fish] ;
% X = [cat, eats, angry, small, bird] ;
% X = [cat, eats, angry, angry, cat] ;
% X = [cat, eats, angry, angry, dog] ;
% X = [cat, eats, angry, angry, fish] ;
% X = [cat, eats, angry, angry, bird] ;
% X = [cat, eats, the, cat] ;
% X = [cat, eats, the, dog] ;
% X = [cat, eats, the, fish] ;
% X = [cat, eats, the, bird] ;
% X = [cat, eats, the, big, cat] ;
% X = [cat, eats, the, big, dog] ;
% X = [cat, eats, the, big, fish] ;
% X = [cat, eats, the, big, bird] ;
% X = [cat, eats, the, small, cat] ;
% X = [cat, eats, the, small, dog] ;
% X = [cat, eats, the, small, fish] ;
% X = [cat, eats, the, small, bird] ;
% X = [cat, eats, the, angry, cat] ;
% X = [cat, eats, the, angry, dog] ;
% X = [cat, eats, the, angry, fish] ;
% X = [cat, eats, the, angry, bird] ;
% X = [cat, eats, the, big, big, cat] ;
% X = [cat, eats, the, big, big, dog] ;
% X = [cat, eats, the, big, big, fish] ;
% X = [cat, eats, the, big, big, bird] ;
% X = [cat, eats, the, big, small, cat] ;
% X = [cat, eats, the, big, small, dog] ;
% X = [cat, eats, the, big, small, fish] ;
% X = [cat, eats, the, big, small, bird] ;
% X = [cat, eats, the, big, angry, cat] ;
% X = [cat, eats, the, big, angry, dog] ;
% X = [cat, eats, the, big, angry, fish] ;
% X = [cat, eats, the, big, angry, bird] ;
% X = [cat, eats, the, small, big, cat] ;
% X = [cat, eats, the, small, big, dog] ;
% X = [cat, eats, the, small, big, fish] ;
% X = [cat, eats, the, small, big, bird] ;