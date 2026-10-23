module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<1.254000e+01> : tensor<f32>}> : () -> tensor<f32>
    %1 = "tosa.const"() <{values = dense<true> : tensor<5xi1>}> : () -> tensor<5xi1>
    %2 = tosa.floor %0 : (tensor<f32>) -> tensor<f32>
    %3 = tosa.reduce_sum %1 {axis = 0 : i32} : (tensor<5xi1>) -> tensor<1xi1>
    %4 = tosa.add %2, %2 : (tensor<f32>, tensor<f32>) -> tensor<f32>
    %5 = tosa.argmax %3 {axis = 0 : i32} : (tensor<1xi1>) -> tensor<i32>
    %cast = tensor.cast %4 : tensor<f32> to tensor<*xf32>
    %cast_0 = tensor.cast %5 : tensor<i32> to tensor<*xi32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefI32(%cast_0) : (tensor<*xi32>) -> ()
    return
  }
}

