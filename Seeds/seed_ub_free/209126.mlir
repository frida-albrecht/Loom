module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-191> : tensor<4xi32>}> : () -> tensor<4xi32>
    %1 = "tosa.const"() <{values = dense<-136> : tensor<4xi32>}> : () -> tensor<4xi32>
    %2 = "tosa.const"() <{values = dense<7.530000e+01> : tensor<f32>}> : () -> tensor<f32>
    %c0 = "tosa.const"() <{values = dense<0> : tensor<4xi32>}> : () -> tensor<4xi32>
    %c31 = "tosa.const"() <{values = dense<31> : tensor<4xi32>}> : () -> tensor<4xi32>
    %a0 = tosa.maximum %1, %c0 : (tensor<4xi32>, tensor<4xi32>) -> tensor<4xi32>
    %a1 = tosa.minimum %a0, %c31 : (tensor<4xi32>, tensor<4xi32>) -> tensor<4xi32>
    %3 = tosa.logical_right_shift %0, %a1 : (tensor<4xi32>, tensor<4xi32>) -> tensor<4xi32>
    %4 = tosa.rsqrt %2 : (tensor<f32>) -> tensor<f32>
    %5 = tosa.ceil %4 : (tensor<f32>) -> tensor<f32>
    %6 = tosa.bitwise_not %3 : (tensor<4xi32>) -> tensor<4xi32>
    %7 = tosa.tanh %4 : (tensor<f32>) -> tensor<f32>
    %8 = tosa.maximum %3, %6 : (tensor<4xi32>, tensor<4xi32>) -> tensor<4xi32>
    %9 = tosa.argmax %8 {axis = 0 : i32} : (tensor<4xi32>) -> tensor<i32>
    %10 = "tosa.const"() <{values = dense<0> : tensor<1xi32>}> : () -> tensor<1xi32>
    %11 = tosa.transpose %6 {perms = array<i32: 0>} : (tensor<4xi32>) -> tensor<4xi32>
    %cast = tensor.cast %5 : tensor<f32> to tensor<*xf32>
    %cast_0 = tensor.cast %7 : tensor<f32> to tensor<*xf32>
    %cast_1 = tensor.cast %9 : tensor<i32> to tensor<*xi32>
    %cast_2 = tensor.cast %11 : tensor<4xi32> to tensor<*xi32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    call @printMemrefI32(%cast_1) : (tensor<*xi32>) -> ()
    call @printMemrefI32(%cast_2) : (tensor<*xi32>) -> ()
    return
  }
}