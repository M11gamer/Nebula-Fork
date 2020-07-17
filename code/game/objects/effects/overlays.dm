/obj/effect/overlay
	name = "overlay"
	unacidable = 1
	var/i_attached //Added for possible image attachments to objects. For hallucinations and the like.

/obj/effect/overlay/beam//Not actually a projectile, just an effect.
	name="beam"
	icon='icons/effects/beam.dmi'
	icon_state= "b_beam"
	var/tmp/atom/BeamSource

/obj/effect/overlay/beam/Initialize()
	. = ..()
	QDEL_IN(src, 1 SECOND)

/obj/effect/overlay/palmtree_r
	name = "Palm tree"
	icon = 'icons/misc/beach2.dmi'
	icon_state = "palm1"
	density = 1
	layer = ABOVE_HUMAN_LAYER
	anchored = 1

/obj/effect/overlay/palmtree_l
	name = "Palm tree"
	icon = 'icons/misc/beach2.dmi'
	icon_state = "palm2"
	density = 1
	layer = ABOVE_HUMAN_LAYER
	anchored = 1

/obj/effect/overlay/coconut
	name = "Coconuts"
	icon = 'icons/misc/beach.dmi'
	icon_state = "coconuts"

/obj/effect/overlay/bluespacify
	name = "Bluespace"
	icon = 'icons/turf/space.dmi'
	icon_state = "bluespacify"
	layer = SUPERMATTER_WALL_LAYER

/obj/effect/overlay/wallrot
	name = "wallrot"
	desc = "Ick..."
	icon = 'icons/effects/wallrot.dmi'
	anchored = 1
	density = 1
	layer = ABOVE_TILE_LAYER
	mouse_opacity = 0

/obj/effect/overlay/wallrot/Initialize()
	. = ..()
	pixel_x += rand(-10, 10)
	pixel_y += rand(-10, 10)

/obj/effect/overlay/bmark
	name = "bullet hole"
	desc = "Well someone shot something."
	icon = 'icons/effects/effects.dmi'
	layer = ABOVE_TILE_LAYER
	icon_state = "scorch"