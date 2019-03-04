<template>
  <period-details :period-id="$route.params.id"></period-details>
</template>

<script>
  import PeriodDetails from '@/components/PeriodDetails.vue'

  export default {
    components: {
      PeriodDetails
    }
  }
</script>
