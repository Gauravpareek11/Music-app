console.log('hi')
document.addEventListener('turbolinks:load', () => {
  console.log('hi');
  const categorySelect = document.querySelector('.category-select');
  const subcategorySelect = document.querySelector('.subcategory-select');
  categorySelect.addEventListener('change', () => {
    console.log('hi');
    const categoryId = categorySelect.value;
    if(categoryId=='') subcategorySelect.innerHTML = '';
    else{
    fetch(`/categories/${categoryId}/subcategories`)
      .then(response => response.json())
      .then(data => {
        subcategorySelect.innerHTML = '';
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
