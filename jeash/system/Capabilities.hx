/**
 * Copyright (c) 2010, Jeash contributors.
 * 
 * All rights reserved.
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 * 
 *   - Redistributions of source code must retain the above copyright
 *     notice, this list of conditions and the following disclaimer.
 *   - Redistributions in binary form must reproduce the above copyright
 *     notice, this list of conditions and the following disclaimer in the
 *     documentation and/or other materials provided with the distribution.
 * 
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
 * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE
 * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
 * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
 * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
 * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
 * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
 * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
 * POSSIBILITY OF SUCH DAMAGE.
 */

package jeash.system;

class Capabilities {
	
	public static var hasAccessibility = false;
	public static var pixelAspectRatio(jeashGetPixelAspectRatio, null):Float;
	public static var screenDPI(jeashGetScreenDPI, null):Float;
	public static var screenResolutionX(jeashGetScreenResolutionX, null):Float;
	public static var screenResolutionY(jeashGetScreenResolutionY, null):Float;
	public static var language(jeashGetLanguage, null):String;
	
	
	// Getters & Setters
	
	
	
	private static function jeashGetPixelAspectRatio():Float { return 1; }
	private static function jeashGetScreenDPI():Float {
		if (screenDPI > 0) return screenDPI;
		
		//little trick of measuring the width of a 1 inch div
		//but sadly most browsers/OSs still return wrong result...
		var body = js.Lib.document.getElementsByTagName("body")[0];
		var testDiv = js.Lib.document.createElement("div");
		testDiv.style.width = testDiv.style.height = "1in";
		testDiv.style.padding = testDiv.style.margin = 0;
		testDiv.style.position = "absolute";
		testDiv.style.top = "-100%";
		body.appendChild(testDiv);
		screenDPI = testDiv.offsetWidth;
		body.removeChild(testDiv);
		
		return screenDPI;
	}
	private static function jeashGetScreenResolutionX():Float { return js.Lib.window.screen.width; }
	private static function jeashGetScreenResolutionY():Float { return js.Lib.window.screen.height; }
	private static function jeashGetLanguage():String { return untyped navigator.language; }
}