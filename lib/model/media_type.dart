enum MediaType {
  movie,
  tv,
}

getMediaTypeName(MediaType mediaType) =>
    mediaType.toString().replaceAll('MediaType.', '');
