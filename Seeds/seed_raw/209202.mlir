module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<1.859600e+02> : tensor<f32>}> : () -> tensor<f32>
    %1 = "tosa.const"() <{values = dense<97.1399993> : tensor<3x2x4x7xf32>}> : () -> tensor<3x2x4x7xf32>
    %2 = "tosa.const"() <{values = dense<-1> : tensor<7x1x6xi8>}> : () -> tensor<7x1x6xi8>
    %3 = "tosa.const"() <{values = dense<-16> : tensor<7x1x6xi8>}> : () -> tensor<7x1x6xi8>
    %4 = tosa.log %0 : (tensor<f32>) -> tensor<f32>
    %5 = tosa.reverse %1 {axis = 2 : i32} : (tensor<3x2x4x7xf32>) -> tensor<3x2x4x7xf32>
    %6 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %7 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %8 = tosa.negate %4, %6, %7 : (tensor<f32>, tensor<1xf32>, tensor<1xf32>) -> tensor<f32>
    %9 = tosa.bitwise_or %2, %3 : (tensor<7x1x6xi8>, tensor<7x1x6xi8>) -> tensor<7x1x6xi8>
    %10 = tosa.ceil %8 : (tensor<f32>) -> tensor<f32>
    %11 = tosa.identity %5 : (tensor<3x2x4x7xf32>) -> tensor<3x2x4x7xf32>
    %cast = tensor.cast %9 : tensor<7x1x6xi8> to tensor<*xi8>
    %cast_0 = tensor.cast %10 : tensor<f32> to tensor<*xf32>
    %cast_1 = tensor.cast %11 : tensor<3x2x4x7xf32> to tensor<*xf32>
    call @printMemrefI8(%cast) : (tensor<*xi8>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    call @printMemrefF32(%cast_1) : (tensor<*xf32>) -> ()
    return
  }
}

