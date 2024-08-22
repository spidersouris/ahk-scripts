#Requires AutoHotkey v2.0

; Note: these hotkeys were designed with the French AZERTY keyboard layout in mind.

^!Space::Send("{U+00A0}") ; CTRL + ALT + Space = non-breaking space (nbsp)

^!SC00A::Send("{U+00C7}") ; CTRL + ALT + ç = uppercase C-cedilla (Ç)

^SC00B::Send("{U+00C0}") ; CTRL + à = uppercase A with grave accent (À)

^!SC008::Send("{U+00C8}") ; CTRL + ALT + è = uppercase E with grave accent (È)

^!SC003::Send("{U+00C9}") ; CTRL + ALT + é = uppercase E with acute accent (É)

^<!SC032::Send("{U+00A0}{U+003F}") ; CTRL + ALT + , = nbsp + question mark

^<!SC035::Send("{U+00A0}{U+0021}") ; CTRL + ALT + ! = nbsp + exclamation mark

^<!SC033::Send("{U+00A0}{U+003B}{U+0020}") ; CTRL + ALT + ; = nbsp + semicolon + normal space

^<!SC034::Send("{U+00A0}{U+003A}{U+0020}") ; CTRL + ALT + : = nbsp + colon + normal space

^!SC056::Send("{U+00AB}{U+00A0}") ; CTRL + ALT + < = French opening quotation mark + nbsp

^SC056::Send("{U+00A0}{U+00BB}") ; CTRL + < = nbsp + French closing quotation mark

^<!SC02D::Send("{U+00A0}{U+00D7}{U+00A0}") ; CTRL + ALT + x = nbsp + multiplication sign + nbsp

^SC04A::Send("{U+2013}") ; CTRL + - (Numpad) = en-dash (–)

^<!SC04A::Send("{U+2014}") ; CTRL + ALT + - (Numpad) = em-dash (—)

<+SC04A::Send("{U+2212}") ; RShift + - (Numpad) = minus sign (−)

<!SC009::Send("{U+005C}") ; ALT + _ = backslash (\)

<!SC033::Send("{U+00B7}") ; ALT + ; = interpunct (·)

<!SC008::Send("{U+0060}") ; ALT + è = backtick (`)

>+SC00C::Send("{U+00BA}") ; RShift + ) = ordinal indicator (º)

!SC012::Send("{U+1D49}") ; ALT + e = superscript e (ᵉ)

!SC013::Send("{U+02B3}") ; ALT + r = superscript r (ʳ)

:*:!oe::{U+0153} ; exclamation mark + oe = œ

:*:...::{U+2026} ; 3 full stops = ellipsis as 1 character (…)

:*:->::{U+2192} ; hyphen + > = right arrow (→)