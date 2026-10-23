module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-1.513900e+02> : tensor<6x8xf32>}> : () -> tensor<6x8xf32>
    %1 = "tosa.const"() <{values = dense<1.701400e+02> : tensor<6x1xf32>}> : () -> tensor<6x1xf32>
    %2 = tosa.add %0, %1 : (tensor<6x8xf32>, tensor<6x1xf32>) -> tensor<6x8xf32>
    %3 = tosa.clamp %2 {max_val = 2.000000e+00 : f32, min_val = -3.800000e+01 : f32} : (tensor<6x8xf32>) -> tensor<6x8xf32>
    %4 = tosa.reduce_sum %3 {axis = 1 : i32} : (tensor<6x8xf32>) -> tensor<6x1xf32>
    %cast = tensor.cast %4 : tensor<6x1xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

