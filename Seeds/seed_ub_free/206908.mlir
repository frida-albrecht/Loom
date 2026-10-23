module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<1.262000e+01> : tensor<7x5xf32>}> : () -> tensor<7x5xf32>
    %1 = tosa.exp %0 : (tensor<7x5xf32>) -> tensor<7x5xf32>
    %2 = tosa.const_shape  {values = dense<[35, 1]> : tensor<2xindex>} : () -> !tosa.shape<2>
    %3 = tosa.reshape %1, %2 : (tensor<7x5xf32>, !tosa.shape<2>) -> tensor<35x1xf32>
    %4 = tosa.concat %3, %3 {axis = 1 : i32} : (tensor<35x1xf32>, tensor<35x1xf32>) -> tensor<35x2xf32>
    %5 = tosa.abs %4 : (tensor<35x2xf32>) -> tensor<35x2xf32>
    %cast = tensor.cast %5 : tensor<35x2xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

