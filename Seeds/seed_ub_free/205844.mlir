module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-120> : tensor<2x9x3x1xi16>}> : () -> tensor<2x9x3x1xi16>
    %1 = tosa.reduce_max %0 {axis = 2 : i32} : (tensor<2x9x3x1xi16>) -> tensor<2x9x1x1xi16>
    %2 = tosa.bitwise_or %1, %1 : (tensor<2x9x1x1xi16>, tensor<2x9x1x1xi16>) -> tensor<2x9x1x1xi16>
    %cast = tensor.cast %2 : tensor<2x9x1x1xi16> to tensor<*xi16>
    call @printMemrefI16(%cast) : (tensor<*xi16>) -> ()
    return
  }
}

