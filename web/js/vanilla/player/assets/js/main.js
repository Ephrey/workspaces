class Music {
  playList = [];
  currentPlaying = { id: null, status: null };
  selectedTrack = null;
  audioPlayer = null;
  timer_current_time = "";
  timer_total_time = "";
  progressBar = "";
  pauseButton = "assets/icons/pause.png";
  playButton = "assets/icons/play.png";
  shuffleSelectedIcon = "assets/icons/shuffle_active.png";
  repeatAllTrack = "assets/icons/repeat_active.png";
  repeatOneTrack = "assets/icons/repeat_one_active.png";
  shuffleUnSelectedIcon = "assets/icons/shuffle.png";
  repeatNoneTrack = "assets/icons/repeat.png";
  shouldShuffle = false;
  shouldRepeat = 0;
  playing = "playing";
  paused = "paused";
  haveBeenPlayed = [];
  currentVolumeLevel = "5";
  validFormat = ["mp3"];

  constructor() {
    this.timer_current_time = document.querySelector(".current_time");
    this.timer_total_time = document.querySelector(".total_time");
    this.progressBar = document.querySelector(".progress_bar");
  }

  /**
   *
   * @param {Array} track
   */
  triggerPlayer(track) {
    const selectedTrack = track;

    if (selectedTrack) {
      this.selectedTrack = selectedTrack;

      const trackId = this.selectedTrack.getAttribute("id");
      if (trackId == this.currentPlaying.id) {
        if (this.currentPlaying.status === this.playing) {
          this.pause();
          return;
        }

        if (this.currentPlaying.status === this.paused) {
          this.play();
          return;
        }
      }

      this.currentPlaying.id = trackId;
      this.selectedTrack.setAttribute("src", this.pauseButton);
      this.selectedTrack.dataset.isplaying = "true";

      const track = this.playList.filter((track) => {
        return track.id == trackId;
      });

      this.audioPlayer = document.querySelector("#player");
      const audioSource = track[0].song; //
      this.audioPlayer.setAttribute("src", audioSource);
      this.play();
      this.switchActionButton();
    } else {
      return false;
    }
  }

  play() {
    this.setVolume(this.currentVolumeLevel);
    this.audioPlayer.play();
    this.currentPlaying.status = this.playing;
    this.selectedTrack.setAttribute("src", this.pauseButton);
    this.updateCurrentTrackCover();
    this.updateTopSectionSongInfoBaseOnCurrentPlaying();
    this.updateMainPlayPauseButtonId();
    this.updateMainPlayPauseButtonStatus("playing");
    this.updateProgressBarAndTimer();
    this.onSongEnd();
  }

  pause() {
    this.audioPlayer.pause();
    this.currentPlaying.status = this.paused;
    this.selectedTrack.setAttribute("src", this.playButton);
    this.updateMainPlayPauseButtonStatus("paused");
    this.stopProgressBarAndTimer();
  }

  /**
   * Switch Buttons play/pause
   */
  switchActionButton() {
    const actionButtons = document.querySelectorAll("img[data-isplaying]");
    actionButtons.forEach((button) => {
      if (
        button.id != this.currentPlaying.id &&
        button.dataset.isplaying == "true"
      ) {
        button.setAttribute("src", this.playButton);
        button.dataset.isplaying = "false";
      }
    });
  }

  updateCurrentTrackCover() {
    // const playerHeroCover = document.querySelector(".player_container");
    // const coverSource = "assets/cover/00" + this.currentPlaying.id + ".jpeg";
    // playerHeroCover.style.backgroundImage = "url(" + coverSource + ")";
  }

  updateTopSectionSongInfoBaseOnCurrentPlaying() {
    const mainSongTitleNameContainer = document.querySelector(".main_title");
    const currentPlaying = this.getCurrentSongFullDetails()[0];
    mainSongTitleNameContainer.innerHTML = currentPlaying.title;
  }

  getCurrentSongFullDetails() {
    return this.playList.filter((track) => {
      return track.id == this.currentPlaying.id;
    });
  }

  /**
   *
   * @param {Number} id
   */
  getTrackById(id) {
    return this.playList.filter((track) => Number(track.id) === Number(id));
  }

  updateProgressBarAndTimer() {
    const audioPlayer = this.audioPlayer;

    window.updateProgressBarAndTimer = setInterval(() => {
      const trackLength = audioPlayer.duration;
      let currentTime = audioPlayer.currentTime;
      let percent = (currentTime / trackLength) * 100;

      this.progressBar.style.width = percent + "%";
      this.timer_current_time.innerHTML = `${getTrackDuration(currentTime)}`;
      this.timer_total_time.innerHTML = `${getTrackDuration(trackLength)}`;
    }, 1000);
  }

  updateMainPlayPauseButtonId() {
    const button = document.querySelector(".main_play_pause_button");
    const currentPlaying = this.getCurrentSongFullDetails()[0];
    this.setAttribute(button, "id", currentPlaying.id);
    button.dataset.isplaying = true;
  }

  updateMainPlayPauseButtonStatus(action) {
    const button = document.querySelector(".main_play_pause_button");
    const trackId = button.getAttribute("id");

    if (action === "paused") {
      this.setAttribute(button, "src", this.playButton);
      this.setAttribute(button, "data-isplaying", false);
      this.setTrackAsPaused(trackId);
    } else {
      this.setAttribute(button, "src", this.pauseButton);
      this.setTrackAsPlaying(trackId);
    }
  }

  /**
   *
   * @param int trackId
   */
  setTrackAsPaused(trackId) {
    const track = document.querySelector("[data-id=song-" + trackId + "]");
    this.setAttribute(track, "src", this.playButton);
    track.dataset.isplaying = false;
  }

  /**
   *
   * @param int trackId
   */
  setTrackAsPlaying(trackId) {
    const track = document.querySelector("[data-id=song-" + trackId + "]");
    this.setAttribute(track, "src", this.pauseButton);
    track.dataset.isplaying = true;
  }

  /**
   *
   * @param HTMLElement element
   * @param HTMLElementAttributeName attribute
   * @param mixed value
   */
  setAttribute(element, attribute, value) {
    element.setAttribute(attribute, value);
  }

  playPrevious() {
    let previousTrackId = 1;

    if (this.currentPlaying.id) {
      const currentTrack = this.getTrackById(this.currentPlaying.id)[0];
      const currentTrackIndex = this.playList.indexOf(currentTrack);

      let previousTrackIndex = currentTrackIndex - 1;
      if (previousTrackIndex < 0) previousTrackIndex = 0;

      const previousTrack = this.playList[previousTrackIndex];
      previousTrackId = previousTrack
        ? Number(previousTrack.id)
        : this.playList[this.playList.length - 1].id;
    }

    if (this.currentPlaying.id == 1) {
      previousTrackId = this.playList.length;
    }

    const previousTrack = document.querySelector(
      "[data-id=song-" + previousTrackId + "]"
    );

    previousTrack.dataset.isplaying = "false";
    this.currentPlaying.id = null;
    previousTrack.click();
  }

  playNext() {
    let nextTrackId = 1;

    if (this.currentPlaying.id) {
      const currentTrack = this.getTrackById(this.currentPlaying.id)[0];
      const currentTrackIndex = this.playList.indexOf(currentTrack);

      const nextTrack = this.playList[currentTrackIndex + 1];

      nextTrackId = nextTrack ? Number(nextTrack.id) : this.playList[0].id;

      console.log(nextTrackId);
    }

    if (this.shouldShuffle) {
      nextTrackId = this.getRandomId();
    }

    if (nextTrackId <= 0 || nextTrackId > this.playList.length) {
      nextTrackId = 1;
    }

    const nextTrack = document.querySelector(
      "[data-id=song-" + nextTrackId + "]"
    );
    nextTrack.dataset.isplaying = "false";
    this.currentPlaying.id = null;
    nextTrack.click();
  }

  getRandomId() {
    let playListSize = this.playList.length;
    this.resetHaveBeenPlayed();
    let randomTrackId = Math.floor(Math.random() * playListSize) + 1;

    while (
      randomTrackId === Number(this.currentPlaying.id) ||
      this.haveBeenPlayed.indexOf(randomTrackId) >= 0
    ) {
      randomTrackId = Math.floor(Math.random() * playListSize) + 1;
    }

    this.currentPlaying.id = randomTrackId;
    this.setHaveBeenPlayed(randomTrackId);
    return randomTrackId;
  }

  resetHaveBeenPlayed() {
    if (this.haveBeenPlayed.length === this.playList.length) {
      this.haveBeenPlayed = [];
    }
  }

  setHaveBeenPlayed(trackId) {
    if (this.haveBeenPlayed.indexOf(trackId) < 0) {
      this.haveBeenPlayed.push(trackId);
    }
  }

  setShuffle(source = null) {
    const shuffleButton = document.querySelector("img[data-role='shuffle']");

    if (this.shouldRepeat === 0 || this.shouldRepeat === 2) {
      if (!source) {
        this.throwError("Oops ! We cannot shuffle on a single track :)");
      }
      shuffleButton.setAttribute("src", this.shuffleUnSelectedIcon);
      this.shouldShuffle = false;
      return;
    }

    this.shouldShuffle = !this.shouldShuffle;
    if (this.shouldShuffle) {
      shuffleButton.setAttribute("src", this.shuffleSelectedIcon);
    } else {
      shuffleButton.setAttribute("src", this.shuffleUnSelectedIcon);
    }
  }

  setRepeat() {
    const repeatButton = document.querySelector("img[data-role='repeat']");
    this.shouldRepeat++;

    if (this.shouldRepeat > 2) {
      this.shouldRepeat = 0;
    }

    switch (this.shouldRepeat) {
      case 1:
        repeatButton.setAttribute("src", this.repeatAllTrack);
        break;
      case 2:
        repeatButton.setAttribute("src", this.repeatOneTrack);
        this.setShuffle("setRepeat");
        break;
      default:
        repeatButton.setAttribute("src", this.repeatNoneTrack);
        this.setShuffle("setRepeat");
        break;
    }

    if (this.audioPlayer) {
      this.onSongEnd();
    }
  }

  setVolume(volumeLevel) {
    let newVolumeLevel = "";

    if (volumeLevel[0] === "0") {
      newVolumeLevel = volumeLevel;
    } else {
      newVolumeLevel = "0." + volumeLevel;
    }

    if (volumeLevel === "10" || volumeLevel === "1.0") {
      newVolumeLevel = "1.0";
    }

    if (!this.audioPlayer) {
      this.currentVolumeLevel = newVolumeLevel;
      this.updateVolumeIcon();
      return;
    }

    this.audioPlayer.volume = newVolumeLevel;
    this.currentVolumeLevel = newVolumeLevel;
    this.updateVolumeIcon();
  }

  mute() {
    let volumeIcon = document.querySelector("#volume_icon");
    let volumeSetting = document.querySelector("#volume_setting");

    if (volumeIcon.dataset.status === "unmute") {
      volumeSetting.value = "0";
      volumeIcon.dataset.status = "mute";
      this.setVolume("0.0");
    } else {
      const volume = "0.5";
      if (this.currentVolumeLevel > 0) {
        volume = this.currentVolumeLevel;
      }
      volumeSetting.value = volume[2];
      volumeIcon.dataset.status = "unmute";
      this.setVolume(volume);
    }

    this.updateVolumeIcon();
  }

  updateVolumeIcon() {
    const volumeIcon = document.querySelector("#volume_icon");
    const volume = Number(this.currentVolumeLevel);

    if (volume === 0) {
      volumeIcon.setAttribute("src", "assets/icons/mute.png");
      volumeIcon.dataset.status = "mute";
      return;
    }

    if (volume > 0 && volume <= 0.5) {
      volumeIcon.setAttribute("src", "assets/icons/speaker.png");
      return;
    } else if (volume > 0.5 && volume <= 0.8) {
      volumeIcon.setAttribute("src", "assets/icons/speaker_high.png");
      return;
    } else if (volume > 0.8 && volume <= 1) {
      volumeIcon.setAttribute("src", "assets/icons/speaker_max.png");
      this.throwError("High volume can harm your ears !");
      return;
    }
  }

  throwError(message) {
    const errorContainer = document.querySelector(".error_container");
    errorContainer.firstChild.innerHTML = message;
    errorContainer.classList.remove("hide_error");

    window.hideError = setTimeout(function () {
      errorContainer.classList.add("hide_error");
      clearTimeout(window.hideError);
    }, 3000);
  }

  playListRenderer() {
    let playList = "";
    this.playList.map((track) => {
      const { id, artist, title, cover, length } = track;
      playList += `
       <div class="single_song_container">
          <div class="artist_cover">
            <img src="assets/cover/${cover}" alt="" />
          </div>
          <div class="music_title_and_length">
            <div>
              <div class="song_title">${title}</div>
              <div class="artist_name">${artist}</div>
              <div data-length="" class="length">${length}</div>
            </div>
          </div>
          <div class="action_buttons">
            <img
              id="${id}"
              data-id="song-${id}"
              data-isplaying="false"
              data-role="play"
              src="assets/icons/play.png"
              alt=""
            />
          </div>
       </div>`;
    });
    return playList;
  }

  onSongEnd() {
    this.audioPlayer.onended = () => {
      switch (this.shouldRepeat) {
        case 1:
          this.playNext();
          break;
        case 2:
          this.selectedTrack.dataset.isplaying = "false";
          this.play(this.selectedTrack);
          break;
        default:
          this.resetAllActionButtons();
          this.stopProgressBarAndTimer();
          this.timer_current_time.innerHTML = "00:00";
          this.timer_total_time.innerHTML = "00:00";
          break;
      }
    };
  }

  resetAllActionButtons() {
    document.querySelectorAll("img[data-isplaying]").forEach((button) => {
      button.setAttribute("src", this.playButton);
      button.dataset.isplaying = "false";
    });
  }

  stopProgressBarAndTimer() {
    clearInterval(window.updateProgressBarAndTimer);
  }
}

/**
 *
 * @param {ChangeEvent} e
 */
function getPlaylist(e) {
  const files = e.target.files;
  const tracks = removeUnsupportedFiles(files);

  if (!tracks.length) {
    musics.throwError("All provided files have bad format ! Good try :)");
    return false;
  }

  for (let e = 0; e < tracks.length; e++) {
    const iteration = e + 1;

    const track = tracks[e];
    const trackName = getTrackName(track.name);
    const trackURL = URL.createObjectURL(track);

    const audio = new Audio(trackURL);
    audio.addEventListener("loadeddata", () => {
      const audioDetails = {
        id: iteration,
        artist: trackName,
        title: trackName,
        song: trackURL,
        cover: "default.jpg",
        length: getTrackDuration(audio.duration),
      };

      musics.playList.push(audioDetails);

      if (iteration === tracks.length) {
        console.log(musics.playList);
        startPlaying();
      }
    });
  }
}

function removeUnsupportedFiles(files) {
  const supportedFiles = [];
  for (let e = 0; e < files.length; e++) {
    const track = files[e];
    const format = extractTrackFormat(track.name);
    if (isValidFormat(format)) {
      tracksUrl = supportedFiles.push(track);
    }
  }

  return supportedFiles;
}

function startPlaying() {
  let playerInterface = document.querySelector("#music_container"),
    playListContainer = document.querySelector(".play_list_container");

  playListContainer.innerHTML = musics.playListRenderer();
  playerInterface.addEventListener("click", (e) => {
    triggerPlayer(e, musics);
  });
}

function triggerPlayer(e, musics) {
  const selectedTrack = e.target;
  if (!selectedTrack) return;
  const triggeredAction = selectedTrack.dataset.role;

  switch (triggeredAction) {
    case "play":
      musics.triggerPlayer(selectedTrack);
      break;
    case "previous":
      musics.playPrevious();
      break;
    case "next":
      musics.playNext();
      break;
    case "shuffle":
      musics.setShuffle();
      break;
    case "repeat":
      musics.setRepeat();
      break;
    case "volume":
      musics.setVolume(selectedTrack.value);
      break;
    case "mute":
      musics.mute();
      break;
    default:
      return;
  }
}

function getTrackName(name) {
  const splitTrackName = name.split(".");
  // remove track format from the name
  splitTrackName.pop();
  // join and return the track name without the format at the end
  let newTrackName = splitTrackName.join(" ");

  if (newTrackName.length > 20) {
    return newTrackName.substring(0, 17) + "...";
  }

  return newTrackName;
}

function getTrackDuration(duration) {
  if (!duration) return "00:00";

  let minutes = Math.floor(duration / 60);
  let seconds = Math.floor(duration - minutes * 60);

  if (minutes < 10) minutes = "0" + minutes;
  if (seconds < 10) seconds = "0" + seconds;

  return minutes + ":" + seconds;
}

function isValidFormat(format) {
  return musics.validFormat.indexOf(format) >= 0;
}

function extractTrackFormat(track) {
  const peacesOfTrack = track.split(".");
  return peacesOfTrack[peacesOfTrack.length - 1];
}

const uploadButton = document.querySelector("#music_upload");
uploadButton.addEventListener("change", getPlaylist);

const musics = new Music();
