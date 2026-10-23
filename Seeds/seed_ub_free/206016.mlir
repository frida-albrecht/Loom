module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<155> : tensor<10x3x1x10xi16>}> : () -> tensor<10x3x1x10xi16>
    %1 = tosa.reduce_max %0 {axis = 3 : i32} : (tensor<10x3x1x10xi16>) -> tensor<10x3x1x1xi16>
    %2 = tosa.bitwise_and %1, %1 : (tensor<10x3x1x1xi16>, tensor<10x3x1x1xi16>) -> tensor<10x3x1x1xi16>
    %3 = tosa.bitwise_and %2, %2 : (tensor<10x3x1x1xi16>, tensor<10x3x1x1xi16>) -> tensor<10x3x1x1xi16>
    %4 = tosa.concat %3, %3 {axis = 1 : i32} : (tensor<10x3x1x1xi16>, tensor<10x3x1x1xi16>) -> tensor<10x6x1x1xi16>
    %cast = tensor.cast %4 : tensor<10x6x1x1xi16> to tensor<*xi16>
    call @printMemrefI16(%cast) : (tensor<*xi16>) -> ()
    return
  }
}

