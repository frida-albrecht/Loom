module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-12> : tensor<7x2xi32>}> : () -> tensor<7x2xi32>
    %1 = "tosa.const"() <{values = dense<8.907000e+01> : tensor<f32>}> : () -> tensor<f32>
    %2 = "tosa.const"() <{values = dense<1.654500e+02> : tensor<f32>}> : () -> tensor<f32>
    %3 = tosa.clamp %0 {max_val = 28 : i32, min_val = -50 : i32} : (tensor<7x2xi32>) -> tensor<7x2xi32>
    %4 = tosa.pow %1, %2 : (tensor<f32>, tensor<f32>) -> tensor<f32>
    %5 = tosa.ceil %4 : (tensor<f32>) -> tensor<f32>
    %6 = tosa.reduce_min %3 {axis = 0 : i32} : (tensor<7x2xi32>) -> tensor<1x2xi32>
    %7 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %8 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %9 = tosa.negate %5, %7, %8 : (tensor<f32>, tensor<1xf32>, tensor<1xf32>) -> tensor<f32>
    %10 = tosa.sub %4, %5 : (tensor<f32>, tensor<f32>) -> tensor<f32>
    %11 = tosa.logical_left_shift %6, %6 : (tensor<1x2xi32>, tensor<1x2xi32>) -> tensor<1x2xi32>
    %12 = tosa.sigmoid %10 : (tensor<f32>) -> tensor<f32>
    %13 = tosa.logical_right_shift %11, %11 : (tensor<1x2xi32>, tensor<1x2xi32>) -> tensor<1x2xi32>
    %14 = tosa.sigmoid %12 : (tensor<f32>) -> tensor<f32>
    %cast = tensor.cast %9 : tensor<f32> to tensor<*xf32>
    %cast_0 = tensor.cast %13 : tensor<1x2xi32> to tensor<*xi32>
    %cast_1 = tensor.cast %14 : tensor<f32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefI32(%cast_0) : (tensor<*xi32>) -> ()
    call @printMemrefF32(%cast_1) : (tensor<*xf32>) -> ()
    return
  }
}

