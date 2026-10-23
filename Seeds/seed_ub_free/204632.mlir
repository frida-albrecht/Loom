module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-7.602000e+01> : tensor<7x2x6xf32>}> : () -> tensor<7x2x6xf32>
    %1 = "tosa.const"() <{values = dense<-70> : tensor<6x5x8xi16>}> : () -> tensor<6x5x8xi16>
    %2 = "tosa.const"() <{values = dense<35> : tensor<1x1x1xi16>}> : () -> tensor<1x1x1xi16>
    %3 = tosa.reduce_min %0 {axis = 2 : i32} : (tensor<7x2x6xf32>) -> tensor<7x2x1xf32>
    %c0 = "tosa.const"() <{values = dense<0> : tensor<1x1x1xi16>}> : () -> tensor<1x1x1xi16>
    %t0 = tosa.maximum %2, %c0 : (tensor<1x1x1xi16>, tensor<1x1x1xi16>) -> tensor<1x1x1xi16>
    %c1 = "tosa.const"() <{values = dense<15> : tensor<1x1x1xi16>}> : () -> tensor<1x1x1xi16>
    %t1 = tosa.minimum %t0, %c1 : (tensor<1x1x1xi16>, tensor<1x1x1xi16>) -> tensor<1x1x1xi16>
    %4 = tosa.arithmetic_right_shift %1, %t1 {round = true} : (tensor<6x5x8xi16>, tensor<1x1x1xi16>) -> tensor<6x5x8xi16>
    %cast = tensor.cast %3 : tensor<7x2x1xf32> to tensor<*xf32>
    %cast_0 = tensor.cast %4 : tensor<6x5x8xi16> to tensor<*xi16>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefI16(%cast_0) : (tensor<*xi16>) -> ()
    return
  }
}