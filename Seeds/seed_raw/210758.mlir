module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-18> : tensor<i32>}> : () -> tensor<i32>
    %1 = "tosa.const"() <{values = dense<-17> : tensor<i32>}> : () -> tensor<i32>
    %2 = "tosa.const"() <{values = dense<-9.822000e+01> : tensor<f32>}> : () -> tensor<f32>
    %3 = "tosa.const"() <{values = dense<-19> : tensor<3x6x7x4xi16>}> : () -> tensor<3x6x7x4xi16>
    %4 = tosa.logical_right_shift %0, %1 : (tensor<i32>, tensor<i32>) -> tensor<i32>
    %5 = tosa.floor %2 : (tensor<f32>) -> tensor<f32>
    %6 = tosa.argmax %3 {axis = 2 : i32} : (tensor<3x6x7x4xi16>) -> tensor<3x6x4xi32>
    %7 = tosa.argmax %6 {axis = 1 : i32} : (tensor<3x6x4xi32>) -> tensor<3x4xi32>
    %8 = tosa.bitwise_and %6, %6 : (tensor<3x6x4xi32>, tensor<3x6x4xi32>) -> tensor<3x6x4xi32>
    %9 = tosa.reciprocal %5 : (tensor<f32>) -> tensor<f32>
    %10 = tosa.reduce_min %6 {axis = 0 : i32} : (tensor<3x6x4xi32>) -> tensor<1x6x4xi32>
    %11 = tosa.bitwise_and %7, %7 : (tensor<3x4xi32>, tensor<3x4xi32>) -> tensor<3x4xi32>
    %12 = tosa.bitwise_xor %11, %7 : (tensor<3x4xi32>, tensor<3x4xi32>) -> tensor<3x4xi32>
    %13 = tosa.argmax %6 {axis = 2 : i32} : (tensor<3x6x4xi32>) -> tensor<3x6xi32>
    %14 = tosa.argmax %13 {axis = 1 : i32} : (tensor<3x6xi32>) -> tensor<3xi32>
    %15 = tosa.intdiv %14, %14 : (tensor<3xi32>, tensor<3xi32>) -> tensor<3xi32>
    %16 = tosa.bitwise_or %12, %12 : (tensor<3x4xi32>, tensor<3x4xi32>) -> tensor<3x4xi32>
    %17 = tosa.reduce_max %14 {axis = 0 : i32} : (tensor<3xi32>) -> tensor<1xi32>
    %18 = tosa.tanh %5 : (tensor<f32>) -> tensor<f32>
    %19 = tosa.ceil %18 : (tensor<f32>) -> tensor<f32>
    %20 = tosa.reverse %17 {axis = 0 : i32} : (tensor<1xi32>) -> tensor<1xi32>
    %21 = tosa.tanh %18 : (tensor<f32>) -> tensor<f32>
    %cast = tensor.cast %4 : tensor<i32> to tensor<*xi32>
    %cast_0 = tensor.cast %8 : tensor<3x6x4xi32> to tensor<*xi32>
    %cast_1 = tensor.cast %9 : tensor<f32> to tensor<*xf32>
    %cast_2 = tensor.cast %10 : tensor<1x6x4xi32> to tensor<*xi32>
    %cast_3 = tensor.cast %15 : tensor<3xi32> to tensor<*xi32>
    %cast_4 = tensor.cast %16 : tensor<3x4xi32> to tensor<*xi32>
    %cast_5 = tensor.cast %19 : tensor<f32> to tensor<*xf32>
    %cast_6 = tensor.cast %20 : tensor<1xi32> to tensor<*xi32>
    %cast_7 = tensor.cast %21 : tensor<f32> to tensor<*xf32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    call @printMemrefI32(%cast_0) : (tensor<*xi32>) -> ()
    call @printMemrefF32(%cast_1) : (tensor<*xf32>) -> ()
    call @printMemrefI32(%cast_2) : (tensor<*xi32>) -> ()
    call @printMemrefI32(%cast_3) : (tensor<*xi32>) -> ()
    call @printMemrefI32(%cast_4) : (tensor<*xi32>) -> ()
    call @printMemrefF32(%cast_5) : (tensor<*xf32>) -> ()
    call @printMemrefI32(%cast_6) : (tensor<*xi32>) -> ()
    call @printMemrefF32(%cast_7) : (tensor<*xf32>) -> ()
    return
  }
}

