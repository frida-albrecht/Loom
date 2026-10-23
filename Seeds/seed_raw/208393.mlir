module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<45> : tensor<7x2x6xi16>}> : () -> tensor<7x2x6xi16>
    %1 = "tosa.const"() <{values = dense<147> : tensor<1x2x1xi16>}> : () -> tensor<1x2x1xi16>
    %2 = "tosa.const"() <{values = dense<1.375000e+01> : tensor<f32>}> : () -> tensor<f32>
    %3 = "tosa.const"() <{values = dense<196> : tensor<4x7x10x8xi32>}> : () -> tensor<4x7x10x8xi32>
    %4 = "tosa.const"() <{values = dense<-72> : tensor<1x1x10x1xi32>}> : () -> tensor<1x1x10x1xi32>
    %5 = tosa.logical_left_shift %0, %1 : (tensor<7x2x6xi16>, tensor<1x2x1xi16>) -> tensor<7x2x6xi16>
    %6 = tosa.tanh %2 : (tensor<f32>) -> tensor<f32>
    %7 = tosa.reverse %5 {axis = 2 : i32} : (tensor<7x2x6xi16>) -> tensor<7x2x6xi16>
    %8 = tosa.arithmetic_right_shift %7, %7 {round = false} : (tensor<7x2x6xi16>, tensor<7x2x6xi16>) -> tensor<7x2x6xi16>
    %9 = tosa.minimum %3, %4 : (tensor<4x7x10x8xi32>, tensor<1x1x10x1xi32>) -> tensor<4x7x10x8xi32>
    %10 = tosa.tanh %6 : (tensor<f32>) -> tensor<f32>
    %cast = tensor.cast %8 : tensor<7x2x6xi16> to tensor<*xi16>
    %cast_0 = tensor.cast %9 : tensor<4x7x10x8xi32> to tensor<*xi32>
    %cast_1 = tensor.cast %10 : tensor<f32> to tensor<*xf32>
    call @printMemrefI16(%cast) : (tensor<*xi16>) -> ()
    call @printMemrefI32(%cast_0) : (tensor<*xi32>) -> ()
    call @printMemrefF32(%cast_1) : (tensor<*xf32>) -> ()
    return
  }
}

