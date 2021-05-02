<template>
  <div class="d-inline-flex flex-row p-1">
    <input
      type="name"
      class="form-control"
      placeholder="Name"
      v-model="extParam.name"
    />
    <input
      type="value"
      class="form-control"
      placeholder="Value"
      v-model="extParam.value"
    />
    <div class="px-1">
      <button class="btn btn-outline-link" v-on:click="removeExtParam"><i class="bi bi-x" style="font-size: 2rem;"></i></button>
    </div>
  </div>
</template>

<script>
export default {
  name: "ExtParam",
  props: {
    extParam: Object,
  },
  methods: {
    removeExtParam: function () {
      this.$emit("removeExtParam", this.extParam);
    },
  },
};
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
input[type="name"] {
  border-bottom-right-radius: 0px;
  border-top-right-radius: 0px;
}

input[type="value"] {
  border-bottom-left-radius: 0px;
  border-top-left-radius: 0px;
  border-left: 0px;
}
</style>
