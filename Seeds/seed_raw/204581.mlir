module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<25> : tensor<5x10x2xi16>}> : () -> tensor<5x10x2xi16>
    %1 = "tosa.const"() <{values = dense<-60> : tensor<1x1x1xi16>}> : () -> tensor<1x1x1xi16>
    %2 = "tosa.const"() <{values = dense<-8.488000e+01> : tensor<2x10x1x8xf32>}> : () -> tensor<2x10x1x8xf32>
    %3 = tosa.logical_right_shift %0, %1 : (tensor<5x10x2xi16>, tensor<1x1x1xi16>) -> tensor<5x10x2xi16>
    %4 = tosa.exp %2 : (tensor<2x10x1x8xf32>) -> tensor<2x10x1x8xf32>
    %5 = tosa.reduce_max %4 {axis = 1 : i32} : (tensor<2x10x1x8xf32>) -> tensor<2x1x1x8xf32>
    %cast = tensor.cast %3 : tensor<5x10x2xi16> to tensor<*xi16>
    %cast_0 = tensor.cast %5 : tensor<2x1x1x8xf32> to tensor<*xf32>
    call @printMemrefI16(%cast) : (tensor<*xi16>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}

