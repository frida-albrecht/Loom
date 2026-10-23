module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-1.349800e+02> : tensor<5xf32>}> : () -> tensor<5xf32>
    %1 = tosa.ceil %0 : (tensor<5xf32>) -> tensor<5xf32>
    %2 = tosa.reverse %1 {axis = 0 : i32} : (tensor<5xf32>) -> tensor<5xf32>
    %3 = tosa.identity %2 : (tensor<5xf32>) -> tensor<5xf32>
    %4 = tosa.const_shape  {values = dense<2> : tensor<1xindex>} : () -> !tosa.shape<1>
    %5 = tosa.tile %3, %4 : (tensor<5xf32>, !tosa.shape<1>) -> tensor<10xf32>
    %cast = tensor.cast %5 : tensor<10xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

