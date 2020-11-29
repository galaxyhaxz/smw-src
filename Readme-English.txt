About:
	This should compile with no errors and produce a file named smw.smc. The
	ROM produced will be identical to Super Mario World (U) and thus playable.
	This code is based off smwdisc all.log with heavy modifications, new
	code and fixes.

	Utilities are stored in the bin folder. They are used to edit or compile
	various things in the game. Hopefully in the future we will see a "romless"
	Lunar Magic that can export level/overworld .bin files. For now, the only way
	is to manually edit a clean ROM in Lunar Magic then export the .bin with a hex
	editor.

	Asar has been modified to write at address 0x000 instead of 0x200 (header). To
	make it write a header specify "asar -h".

Purpose:
	I lost interest in smw hacking so I am releasing this so it doesn't die off.
	I was intending on changing the way smw is hacked so that it can be completely
	rewritten and easily modified. Hopefully someone will make use out of this and
	there will be more .bin editing utilities in the future. It still needs much
	work but I don't have the time to finish it. I put about 3 months of work into
	this total.

Instructions:
	Run make.bat to compile, any errors will appears in the command prompt.
	Run graphics/compression.bat to de-compress or re-compress the graphics.
	Run spc700/samples/encoding.bat to encode or decode brr samples.
	Use Lunar Magic to edit levels and the overworld then a hex editor to export them.
	Use Terra Stripe to edit the layer 3 images.

Version History:
	1.0 (public release): Produces a file identical to the original (U) ROM.

Author: GalaXyHaXz

Credits:
	Nintendo. They still try to sell this game after all these years. :)
	SMWCentral and the folks who made smwdisc (read its credits for a list of people).
	Ice Man - HDMA effects which were used in the HDMA library.
	GreenHammerBro - Gravity bug fix used in the bug fix document.
	GlitchMr - Wiggler point bug fix used in the bug fix docuemnt.

Legal Notice:
	Remember that you still need to own the game before you can have the source code
	as this compiles the ROM itself.