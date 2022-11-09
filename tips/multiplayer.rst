Multiplayer
===========

I'm not really sure how enjoyable it would be to do multiplayer Myth using the Steam Deck. Maybe co-op play? Maybe if everyone else was also on the Deck?

Well regardless, a few words about multiplayer:

The multiplayer modes still work perfectly fine, both co-op and competitive.

It's peer-to-peer and doesn't do any fancy NAT holepunch stuff; anyone hosting a game will need to explicitly configure port-forwarding on their home router so that port 3453 (UDP and TCP) goes to the hosting computer.

To join a game, you either need to know the externally-visible IP address of the host (which the host can find out via sites like `WhatIsMyIP.com`_) in order to do a direct IP connection ... or, the host can set up the game in a lobby in the `Gate of Storms`_ service. In the latter case, anyone connecting to Gate of Storms can see and join the game. (Note that a host can choose to password-protect a game.)

The archived old `Myth Starter Guide`_ still has some relevant info about multiplayer, although it is now out of date when it comes to some specifics of setup and configuration.

.. _WhatIsMyIP.com: https://www.whatismyip.com/
.. _Gate of Storms: http://gateofstorms.net/
.. _Myth Starter Guide: https://web.archive.org/web/20170421203613/http://mythgraveyard.org:80/Myth_Starter_Guide/