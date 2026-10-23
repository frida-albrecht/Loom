module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<128> : tensor<i16>}> : () -> tensor<i16>
    %1 = "tosa.const"() <{values = dense<-3> : tensor<i16>}> : () -> tensor<i16>
    %2 = "tosa.const"() <{values = dense<111> : tensor<2x7xi16>}> : () -> tensor<2x7xi16>
    %3 = "tosa.const"() <{values = dense<7.513000e+01> : tensor<f32>}> : () -> tensor<f32>
    %4 = tosa.logical_right_shift %0, %1 : (tensor<i16>, tensor<i16>) -> tensor<i16>
    %5 = tosa.add %4, %4 : (tensor<i16>, tensor<i16>) -> tensor<i16>
    %6 = tosa.sub %5, %5 : (tensor<i16>, tensor<i16>) -> tensor<i16>
    %7 = tosa.reduce_min %2 {axis = 1 : i32} : (tensor<2x7xi16>) -> tensor<2x1xi16>
    %8 = tosa.concat %7, %7 {axis = 1 : i32} : (tensor<2x1xi16>, tensor<2x1xi16>) -> tensor<2x2xi16>
    %9 = tosa.reciprocal %3 : (tensor<f32>) -> tensor<f32>
    %cast = tensor.cast %6 : tensor<i16> to tensor<*xi16>
    %cast_0 = tensor.cast %8 : tensor<2x2xi16> to tensor<*xi16>
    %cast_1 = tensor.cast %9 : tensor<f32> to tensor<*xf32>
    call @printMemrefI16(%cast) : (tensor<*xi16>) -> ()
    call @printMemrefI16(%cast_0) : (tensor<*xi16>) -> ()
    call @printMemrefF32(%cast_1) : (tensor<*xf32>) -> ()
    return
  }
}

