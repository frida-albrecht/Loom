module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-1.605000e+01> : tensor<5x9x4x8xf32>}> : () -> tensor<5x9x4x8xf32>
    %1 = tosa.sigmoid %0 : (tensor<5x9x4x8xf32>) -> tensor<5x9x4x8xf32>
    %2 = tosa.reduce_product %1 {axis = 3 : i32} : (tensor<5x9x4x8xf32>) -> tensor<5x9x4x1xf32>
    %cast = tensor.cast %2 : tensor<5x9x4x1xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

