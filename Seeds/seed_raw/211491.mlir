module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-6.311000e+01> : tensor<4x4x10xf32>}> : () -> tensor<4x4x10xf32>
    %1 = tosa.reduce_min %0 {axis = 2 : i32} : (tensor<4x4x10xf32>) -> tensor<4x4x1xf32>
    %cast = tensor.cast %1 : tensor<4x4x1xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

