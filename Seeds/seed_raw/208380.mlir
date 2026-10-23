module {
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<76.8899993> : tensor<f32>}> : () -> tensor<f32>
    %1 = "tosa.const"() <{values = dense<-71> : tensor<10x4xi64>}> : () -> tensor<10x4xi64>
    %2 = tosa.reciprocal %0 : (tensor<f32>) -> tensor<f32>
    %3 = tosa.reduce_sum %1 {axis = 1 : i32} : (tensor<10x4xi64>) -> tensor<10x1xi64>
    %4 = tosa.clamp %2 {max_val = 5.100000e+01 : f32, min_val = 1.900000e+01 : f32} : (tensor<f32>) -> tensor<f32>
    %cast = tensor.cast %3 : tensor<10x1xi64> to tensor<*xi64>
    %cast_0 = tensor.cast %4 : tensor<f32> to tensor<*xf32>
    call @printMemrefI64(%cast) : (tensor<*xi64>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}

