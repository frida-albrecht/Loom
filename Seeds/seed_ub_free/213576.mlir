module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-1.286000e+01> : tensor<4x3x9x8xf32>}> : () -> tensor<4x3x9x8xf32>
    %1 = "tosa.const"() <{values = dense<7.936000e+01> : tensor<3xf32>}> : () -> tensor<3xf32>
    %2 = "tosa.const"() <{values = dense<1.269200e+02> : tensor<1xf32>}> : () -> tensor<1xf32>
    %3 = tosa.argmax %0 {axis = 1 : i32} : (tensor<4x3x9x8xf32>) -> tensor<4x9x8xi32>
    %4 = tosa.pow %1, %2 : (tensor<3xf32>, tensor<1xf32>) -> tensor<3xf32>
    %5 = tosa.floor %4 : (tensor<3xf32>) -> tensor<3xf32>
    %6 = tosa.bitwise_or %3, %3 : (tensor<4x9x8xi32>, tensor<4x9x8xi32>) -> tensor<4x9x8xi32>
    %7 = tosa.identity %5 : (tensor<3xf32>) -> tensor<3xf32>
    %8 = tosa.identity %4 : (tensor<3xf32>) -> tensor<3xf32>
    %9 = tosa.clamp %8 {max_val = 9.800000e+01 : f32, min_val = 3.000000e+00 : f32} : (tensor<3xf32>) -> tensor<3xf32>
    %10 = tosa.sigmoid %9 : (tensor<3xf32>) -> tensor<3xf32>
    %11 = tosa.floor %10 : (tensor<3xf32>) -> tensor<3xf32>
    %12 = tosa.reverse %7 {axis = 0 : i32} : (tensor<3xf32>) -> tensor<3xf32>
    %13 = tosa.bitwise_not %3 : (tensor<4x9x8xi32>) -> tensor<4x9x8xi32>
    %14 = tosa.intdiv %13, %13 : (tensor<4x9x8xi32>, tensor<4x9x8xi32>) -> tensor<4x9x8xi32>
    %15 = tosa.add %12, %11 : (tensor<3xf32>, tensor<3xf32>) -> tensor<3xf32>
    %16 = tosa.tanh %15 : (tensor<3xf32>) -> tensor<3xf32>
    %cast = tensor.cast %6 : tensor<4x9x8xi32> to tensor<*xi32>
    %cast_0 = tensor.cast %14 : tensor<4x9x8xi32> to tensor<*xi32>
    %cast_1 = tensor.cast %16 : tensor<3xf32> to tensor<*xf32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    call @printMemrefI32(%cast_0) : (tensor<*xi32>) -> ()
    call @printMemrefF32(%cast_1) : (tensor<*xf32>) -> ()
    return
  }
}

