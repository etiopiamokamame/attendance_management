function article_page() {
  location.href = Routes.articles_path();
  return false;
}

function article_show_page(id) {
  location.href = Routes.article_path(id);
  return false;
}