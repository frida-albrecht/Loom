module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<1.852800e+02> : tensor<5xf32>}> : () -> tensor<5xf32>
    %1 = "tosa.const"() <{values = dense<3.977000e+01> : tensor<1xf32>}> : () -> tensor<1xf32>
    %2 = tosa.pow %0, %1 : (tensor<5xf32>, tensor<1xf32>) -> tensor<5xf32>
    %3 = tosa.concat %2, %2 {axis = 0 : i32} : (tensor<5xf32>, tensor<5xf32>) -> tensor<10xf32>
    %4 = tosa.sigmoid %3 : (tensor<10xf32>) -> tensor<10xf32>
    %5 = tosa.sub %4, %3 : (tensor<10xf32>, tensor<10xf32>) -> tensor<10xf32>
    %6 = tosa.reduce_sum %5 {axis = 0 : i32} : (tensor<10xf32>) -> tensor<1xf32>
    %cast = tensor.cast %6 : tensor<1xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

