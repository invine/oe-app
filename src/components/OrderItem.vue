<template>
  <div class="box">
    <div class="label block">{{ orderitem.id }}</div>
    <div class="columns block">
      <select
        class="input"
        v-model="orderitem.product.productSpecification"
        v-on:change="resetOrderItem"
      >
        <option v-for="s in listSpecs" v-bind:key="s.id" v-bind:value="s">
          {{ s.name }}
        </option>
      </select>
      <select class="input" v-model="orderitem.action" v-if="drawOrderItem">
        <option value="add">Add</option>
        <option value="modify">Modify</option>
        <option value="delete">Delete</option>
        <option value="no_change">No Change</option>
      </select>
      <button class="delete" v-on:click="removeOrderItem()">x</button>
    </div>
    <app-chars
      class="block"
      :chars="orderitem.product.characteristic"
      :specs="getCharSpecs"
    />
    <ext-params class="block" :extParams="orderitem.extParams" />
    <order-items
      class="block"
      v-if="drawOrderItems"
      :orderitems="orderitem.orderItems"
      :specs="specs"
      :parentSpecId="orderitem.product.productSpecification.id"
    />
  </div>
</template>

<script>
import ExtParams from "./ExtParams.vue";
import OrderItems from "./OrderItems.vue";
import AppChars from "./AppChars.vue";
export default {
  name: "OrderItem",
  components: {
    ExtParams,
    OrderItems,
    AppChars,
  },
  props: {
    orderitem: Object,
    specs: Array,
    parentSpecId: String,
  },
  computed: {
    drawOrderItem: function () {
      return this.orderitem.product.productSpecification.name;
    },
    drawOrderItems: function () {
      let relations = (
        this.specs.find(
          (el) =>
            el.externalId == this.orderitem.product.productSpecification.id
        ) || []
      ).entitySpecificationRelationship;
      return relations && relations.length > 0;
    },
    listSpecs: function () {
      if (!this.specs) {
        return [];
      }
      if (this.parentSpecId) {
        let relations = (
          this.specs.find((el) => el.externalId == this.parentSpecId)
            .entitySpecificationRelationship || []
        ).map((el) => el.id);
        return this.specs
          .filter((el) => relations.includes(el.id))
          .map((el) => ({ name: el.name, id: el.externalId }));
      }
      return this.specs.map((el) => ({ name: el.name, id: el.externalId }));
    },
    getCharSpecs: function () {
      if (this.orderitem.product.productSpecification.id && this.specs) {
        return (
          this.specs.find(
            (el) =>
              el.externalId == this.orderitem.product.productSpecification.id
          ) || []
        ).entitySpecCharacteristic;
      }
      return [];
    },
  },
  methods: {
    removeOrderItem: function () {
      this.$emit("removeOrderItem", this.orderitem);
    },
    resetOrderItem: function () {
      this.orderitem.orderItems = [];
      this.orderitem.product.characteristic = (this.getCharSpecs || []).map(
        (el) => ({
          name: el.name,
          value: [""],
        })
      );
    },
  },
};
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
@import "https://cdn.jsdelivr.net/npm/bulma@0.9.2/css/bulma.min.css";
</style>
