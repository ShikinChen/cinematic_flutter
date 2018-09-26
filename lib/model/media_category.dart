enum MediaCategory {
  popular,
  upcoming,
  top_rated,
  on_the_air,
}

getMediaCategoryName(MediaCategory mediaCategory) =>
    mediaCategory.toString().replaceAll('MediaCategory.', '');
