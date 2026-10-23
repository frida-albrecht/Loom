module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-18> : tensor<9xi32>}> : () -> tensor<9xi32>
    %1 = "tosa.const"() <{values = dense<-1.732800e+02> : tensor<f32>}> : () -> tensor<f32>
    %2 = tosa.reduce_min %0 {axis = 0 : i32} : (tensor<9xi32>) -> tensor<1xi32>
    %3 = tosa.bitwise_or %2, %2 : (tensor<1xi32>, tensor<1xi32>) -> tensor<1xi32>
    %4 = tosa.ceil %1 : (tensor<f32>) -> tensor<f32>
    %5 = "tosa.const"() <{values = dense<0> : tensor<1xi32>}> : () -> tensor<1xi32>
    %6 = tosa.transpose %3 {perms = array<i32: 0>} : (tensor<1xi32>) -> tensor<1xi32>
    %7 = tosa.rsqrt %4 : (tensor<f32>) -> tensor<f32>
    %8 = tosa.reduce_product %6 {axis = 0 : i32} : (tensor<1xi32>) -> tensor<1xi32>
    %9 = tosa.tanh %4 : (tensor<f32>) -> tensor<f32>
    %cast = tensor.cast %7 : tensor<f32> to tensor<*xf32>
    %cast_0 = tensor.cast %8 : tensor<1xi32> to tensor<*xi32>
    %cast_1 = tensor.cast %9 : tensor<f32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefI32(%cast_0) : (tensor<*xi32>) -> ()
    call @printMemrefF32(%cast_1) : (tensor<*xf32>) -> ()
    return
  }
}

