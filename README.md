# Project 4 - *Memory Game*

Submitted by: **Jordyn Richmond**

**Memory Game** is a SwiftUI-based card matching game where players flip cards to find matching pairs. The app features animated card flips, adjustable difficulty levels, and a clean grid layout.

Time spent: **10** hours spent in total

## Required Features

The following **required** functionality is completed:

- [x] App loads to display a grid of cards initially placed face-down
- [x] Users can tap cards to toggle their display between the back and the face
- [x] When two matching cards are found, they both disappear from view
- [x] When two cards don't match, they flip back to face-down after a short delay
- [x] User can reset the game and start a new game via a button

The following **optional** features are implemented:

- [x] User can select number of pairs to play with (3, 6, and 10 pairs)
- [x] App allows for user to scroll to see pairs out of view
- [x] Visual polish with colored buttons, card shadows, and styled UI

The following **additional** features are implemented:

- [x] Smooth 3D card flip animation using rotation3DEffect
- [x] Tap protection to prevent flipping more than two cards at a time

## Video Walkthrough

[Guide]().

## Notes

- Working with SwiftUI state management was new, figuring out when to use @State and how SwiftUI re-renders views based on state changes took some getting used to.
- Getting the card flip animation timing right was tricky, especially coordinating the delay before non-matching cards flip back while blocking additional taps during that window.
- Using LazyVGrid for the card layout was straightforward once the GridItem configuration was set up, and wrapping it in a ScrollView handled the overflow for larger pair counts nicely.

## License

    Copyright 2026 Jordyn Richmond

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
