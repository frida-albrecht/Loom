module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-128> : tensor<7x9x9x2xi16>}> : () -> tensor<7x9x9x2xi16>
    %1 = "tosa.const"() <{values = dense<-25> : tensor<7x1x9x1xi16>}> : () -> tensor<7x1x9x1xi16>
    %2 = "tosa.const"() <{values = dense<1.735100e+02> : tensor<10x9xf32>}> : () -> tensor<10x9xf32>
    %c0 = "tosa.const"() <{values = dense<0> : tensor<7x1x9x1xi16>}> : () -> tensor<7x1x9x1xi16>
    %c15 = "tosa.const"() <{values = dense<15> : tensor<7x1x9x1xi16>}> : () -> tensor<7x1x9x1xi16>
    %clamped_lower = tosa.maximum %1, %c0 : (tensor<7x1x9x1xi16>, tensor<7x1x9x1xi16>) -> tensor<7x1x9x1xi16>
    %clamped_shift = tosa.minimum %clamped_lower, %c15 : (tensor<7x1x9x1xi16>, tensor<7x1x9x1xi16>) -> tensor<7x1x9x1xi16>
    %3 = tosa.arithmetic_right_shift %0, %clamped_shift {round = false} : (tensor<7x9x9x2xi16>, tensor<7x1x9x1xi16>) -> tensor<7x9x9x2xi16>
    %4 = tosa.reduce_sum %3 {axis = 0 : i32} : (tensor<7x9x9x2xi16>) -> tensor<1x9x9x2xi16>
    %5 = tosa.abs %4 : (tensor<1x9x9x2xi16>) -> tensor<1x9x9x2xi16>
    %6 = tosa.bitwise_and %5, %4 : (tensor<1x9x9x2xi16>, tensor<1x9x9x2xi16>) -> tensor<1x9x9x2xi16>
    %7 = tosa.bitwise_not %6 : (tensor<1x9x9x2xi16>) -> tensor<1x9x9x2xi16>
    %8 = tosa.tanh %2 : (tensor<10x9xf32>) -> tensor<10x9xf32>
    %cast = tensor.cast %7 : tensor<1x9x9x2xi16> to tensor<*xi16>
    %cast_0 = tensor.cast %8 : tensor<10x9xf32> to tensor<*xf32>
    call @printMemrefI16(%cast) : (tensor<*xi16>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}