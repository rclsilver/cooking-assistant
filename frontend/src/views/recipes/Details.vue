<template>
  <recipe-details :recipe-id="$route.params.id"></recipe-details>
</template>

<script>
  import RecipeDetails from '@/components/RecipeDetails.vue'

  export default {
    components: {
      RecipeDetails
    }
  }
</script>
