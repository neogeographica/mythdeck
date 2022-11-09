Reconfiguration
===============

The MythDeck config uses almost every :strike:`part of the buffalo` control on the Deck, but of course it's still possible to shuffle some things around if you want. For example if you play a lot of mods that use unit inventory, you may not want the inventory action to be squirreled away on that virtual menu, and you'd rather have it on some more immediately accessible button.

This page is a collection of notes about things to be aware of if you are changing the MythDeck controls. If you're not interested in that, skip this page and go play!

Unbound Actions
---------------

There are still quite a few Myth input keys that I didn't bind to any control on the Deck. Here's a mostly-complete list of unbound stuff and why it is unbound:

* Y/Shift-Y to initiate team or global text chat. If you really need to text-chat then you're going to be typing on a (real or virtual) keyboard anyway and can hit the Y key there.
* F3/F4 for volume control. You can use the Deck's volume controls instead.
* F5 for autocam. Doesn't work in singleplayer and isn't very good anyway.
* F6/Shift-F6 and PgUp for in-game toggling of status bar, control bar, and detail textures. You can set these things in Myth preferences.
* Home/End to move the cursor in text fields. Use a mouseclick, or if you're determined to do heavy text chat then use a real keyboard.
* Shift-Backspace to toggle an in-game FPS counter. You can use the Deck's.
* Ctrl-Plus/Minus to auto-win/lose a mission. This might be kinda nice for some folks to have? Not sure where to bind it though.

If something there sounds really useful then maybe there's an existing binding you can sacrifice to swap it in.

Modifier (Combo) Keys
---------------------

A few keys are used in combination with other keys... this includes Shift and Alt which are held to perform combos, but also in a way this includes the F key which is used in sequence with number keys to select formations. If you are changing the control bindings for any of these keys, keep in mind that the control for such a key should do the same thing regardless of whether or not the mode shift is active.

Mode Shift End Delay
--------------------

If you dig into things you may see that the mode-shift behavior ("hold action set layer") of the left trigger has a "Fire End Delay" of 250. So even after releasing left trigger, the mode shift remains in place for a quarter second.

This delay is to help in situations where, after executing a mode-shifted command, you might accidentally release the left trigger a fraction of a second before releasing the command button. Without this delay, the original (non-mode-shifted) function of that command button would activate as soon as you released the left trigger.

I would guess that you won't really need to know or care about this detail, but I mention it here for two reasons:

* You may want to change the delay if you notice that it is causing unexpected behavior by being too long or too short.

* If you're reconfiguring things to move the mode-shift button somewhere other than left trigger, you'll want to make sure to *remove* the "Fire End Delay" from the left trigger (reduce it to zero) and probably *add* it to whatever other button you are wanting to use for the mode shift.