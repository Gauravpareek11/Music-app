document.addEventListener('turbolinks:load', () => {
  const categorySelect = document.querySelector('.category-select');
  const subcategorySelect = document.querySelector('.subcategory-select');
  var subCategoryValue = subcategorySelect.getAttribute('data-default-sub-category');
  categorySelect.addEventListener('change', () => {
    const categoryId = categorySelect.value;
    if(categoryId=='') subcategorySelect.innerHTML = '';
    else{
    fetch(`/categories/${categoryId}/subcategories`)
      .then(response => response.json())
      .then(data => {
        subcategorySelect.innerHTML = '';
        const defaultOption = document.createElement('option');
        defaultOption.value = '';
        defaultOption.text = 'Please Select';
        subcategorySelect.appendChild(defaultOption);
        data.forEach(subcategory => {
          const option = document.createElement('option');
          option.value = subcategory.id;
          option.text = subcategory.items;
          subcategorySelect.appendChild(option);
        });
        subcategorySelect.disabled = false;
      });
    }
  });
});
