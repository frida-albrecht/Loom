module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-42> : tensor<5xi16>}> : () -> tensor<5xi16>
    %1 = "tosa.const"() <{values = dense<-152> : tensor<1xi16>}> : () -> tensor<1xi16>
    %2 = tosa.add %0, %1 : (tensor<5xi16>, tensor<1xi16>) -> tensor<5xi16>
    %3 = "tosa.const"() <{values = dense<0> : tensor<1xi16>}> : () -> tensor<1xi16>
    %4 = "tosa.const"() <{values = dense<0> : tensor<1xi16>}> : () -> tensor<1xi16>
    %5 = tosa.negate %2, %3, %4 : (tensor<5xi16>, tensor<1xi16>, tensor<1xi16>) -> tensor<5xi16>
    %6 = tosa.const_shape  {values = dense<1> : tensor<1xindex>} : () -> !tosa.shape<1>
    %7 = tosa.tile %5, %6 : (tensor<5xi16>, !tosa.shape<1>) -> tensor<5xi16>
    %8 = tosa.reduce_max %7 {axis = 0 : i32} : (tensor<5xi16>) -> tensor<1xi16>
    %cast = tensor.cast %8 : tensor<1xi16> to tensor<*xi16>
    call @printMemrefI16(%cast) : (tensor<*xi16>) -> ()
    return
  }
}

