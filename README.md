# you2be
The motivation for this project is a bit dubious. In 11th grade my highschool administration began limiting student internet access. One of the limitations they made restricted Youtube access to only videos which the administration had placed on a whitelist. My friends and I were beginning to be interested in poker, and wanted to watch professional tournaments during study hall. Of course, none of these videos were whitelisted, and so I developed this tool so that we could watch them anyway.

The script works by navigating Youtube through it's source code. It scrapes results from a user-entered query. The user selects a video from these results, and the script now scrapes the source url for the video content. 

I rewrote some of the webscraping to make the script functional again (as of 12/30/2022) since Youtube source code updates had completely broken it. The organization and style of the script remain untouched which provides a snapshot of my highschool coding brain.

### Potential TODOs:
- streamline user interaction system
- allow for selection of video quality
- support sourcing viral videos
  - source links for immensely popular videos (like [Waka Waka](https://www.youtube.com/watch?v=pRpeEdMmmQ0)) receive a 403 error 
