// app/assets/javascripts/recipe_generator.js

document.addEventListener('DOMContentLoaded', () => {
  document.getElementById('recipe-form').addEventListener('submit', async (e) => {
    e.preventDefault();

    const form = e.target;
    const formData = new FormData(form);

    const loader = document.getElementById('loader');
    loader.style.display = 'block';

    const recipeContainer = document.getElementById('recipe-container');
    recipeContainer.innerText = '';

    try {
    const response = await fetch(form.action, {
      method: form.method,
      headers: {
        'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').content,
      },
      body: formData,
    });

    if (response.ok) {
      const data = await response.json();
      recipeContainer.innerText = data.recipe || "No recipe found.";
    } else {
      recipeContainer.innerText = "Error generating recipe.";
    }
    } catch (error) {
      recipeContainer.innerText = "An error occurred while generating the recipe.";
    } finally {
      loader.style.display = 'none';
    }
  });
});
  