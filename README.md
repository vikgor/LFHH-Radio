# LFHH 

## TO DO:

- [x] show track title and controls in control panel & lock screen
- [x] add loading labels (between the pressed button and audio actually playing)
- [x] add volume & airplay
    - [x] Fix volume [link](https://medium.com/@javedmultani16/mpvolumeview-ios-ac2af8ac7a0)
    - [x] Check AirPlay
- [x] add "Live" mark in lock screen and control center [link](https://stackoverflow.com/questions/45203482/mpnowplayinginfocenter-live-icon?rq=1)
- [x] History -> Table View
    - [x] Get 10 tracks and populate tableview
    - [x] Normal encoding
    - [x] Refresh with pull [link](https://stackoverflow.com/questions/24475792/how-to-use-pull-to-refresh-in-swift)
- [ ] sleep timer
    - [x] Stop audio on button press from another VC [link](http://www.systeen.com/2016/12/02/stop-audio-player-another-view-controller-using-notificationcenter-swift-3/)
    - [x] Fix crash on sleep timer pausing the unplaying audio
    - [x] Set up time with Picker View
    - [x] Show countdown timer or any other indication of a timer turned on
    - [x] Be able to set up a new timer after one is finished
    - [x] Check if timer is currently on, reset it on a new start
    - [ ] Fix stop when audio is playing and the timre is resumed without choosing a different value in picker
- [ ] Resume audio after interruption
- [ ] check battery drain
- [x] Code refactoring
    - [x] Main View
    - [x] Timer
    - [x] Playlist
- [ ] splitFileNameIntoArtistAndTrack(): may crash if name format isn't "aaa - bbb.mp3"
- [x] checkIfAlive(): Don't forget to check offline mode
- [ ] Design
    - [ ] Fix volume view width
    - [ ] Long track titles fix
    - [ ] add views/buttons (contacts, song history, save current song option, other links and stuff)
    - [ ] Design improvements
- [ ] Alarm
