<template>
  <a-row>
    <a-col :span="24">
      <a-breadcrumb>
        <a-breadcrumb-item>
          <a href="/">
            <a-icon type="home" />
          </a>
        </a-breadcrumb-item>
        <a-breadcrumb-item>Compra</a-breadcrumb-item>
        <a-breadcrumb-item>Pago</a-breadcrumb-item>
      </a-breadcrumb>

      <a-page-header
        style="border-bottom: 1px solid rgb(235, 237, 240); margin-bottom: 16px"
        title="Pago de Compra"
      />

      <a-form :form="form" @submit="handleSubmit">
        <a-row :gutter="[16,16]" type="flex" justify="space-around">
          
          <a-col :span="6">
            <a-form-item label="Documento">
              <a-input
                v-decorator="[
                  'document',
                  {
                    rules: [messageRequired],
                  },
                ]"
              />
            </a-form-item>
          </a-col>
          
          <a-col :span="6">
            <a-form-item label="Teléfono">
              <a-input
                v-decorator="[
                  'phone',
                  {
                    rules: [messageRequired],
                  },
                ]"
              />
            </a-form-item>
          </a-col>

          <a-col :span="6">
            <a-form-item label="Monto">
              <a-input
                v-decorator="[
                  'quantity',
                  {
                    rules: [messageRequired],
                  },
                ]"
              />
            </a-form-item>
          </a-col>

          <a-col :span="6" v-if="secondStep">
            <a-form-item label="Codigo">
              <a-input
                v-decorator="[
                  'code',
                  {
                    rules: [messageRequired],
                  },
                ]"
              />
            </a-form-item>
          </a-col>
         
        </a-row>
        <a-row style="text-align: center;">
            <a-button type="primary" html-type="submit" v-if="!secondStep"> Pagar </a-button>
            <a-button type="primary" html-type="submit" v-if="secondStep"> Confirmar Pago </a-button>
        </a-row>

        <a-divider orientation="right" v-if="secondStep">
          Último paso para finalizar su compra
        </a-divider>
        <p v-if="secondStep">
          Revice su bandeja de entrada del correo electrónico donde le hemos enviado un código para confirmar su pago!
        </p>
      </a-form>
    </a-col>
  </a-row>
</template>

<script>

export default {
  data() {
    return {
      payment: {},
      secondStep: false,
      messageRequired: { 
        required: true, 
        message: 'Campo requerido!' 
      },
      form: this.$form.createForm(this, { name: 'coordinated' }),
    }
  },
  methods: {
    openNotification(resp, type) {
      this.$notification[type]({
        message: type === "success" ? "¡ÉXITO!" : type === "error" ? "¡ALERTA!" : "¡ATENCIÓN!" ,
        description: type === "error" ? "Hubo un error al comunicar con el servidor." : resp ,
        placement: 'bottomRight',
      });
    },
    async handleSubmit(e) {
      e.preventDefault();
      this.form.validateFields((err, values) => {
        if (!err) { this.payment = values; } 
        else { this.payment = false }
      });

      if (this.payment) { 
        const response = await this.$axios.$post('http://local-epayco/restpayment/pay', this.payment)
        try {
          if (response.code === 200) {
            this.openNotification(response.message, "success");
            this.secondStep = true;
            if(this.payment.code){
              this.form.resetFields();
              this.secondStep = false;
            }
          } else { 
            this.openNotification(response.message, "warning");
          }
        } catch (error) {
          this.openNotification(error, "error");
        }
      }
    },
  },
}
</script>
