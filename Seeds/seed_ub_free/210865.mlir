module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<1> : tensor<9xi8>}> : () -> tensor<9xi8>
    %1 = "tosa.const"() <{values = dense<-1.419000e+02> : tensor<5x1x4x1xf32>}> : () -> tensor<5x1x4x1xf32>
    %2 = tosa.const_shape  {values = dense<1> : tensor<1xindex>} : () -> !tosa.shape<1>
    %3 = tosa.tile %0, %2 : (tensor<9xi8>, !tosa.shape<1>) -> tensor<9xi8>
    %4 = tosa.rsqrt %1 : (tensor<5x1x4x1xf32>) -> tensor<5x1x4x1xf32>
    %5 = tosa.reduce_product %4 {axis = 3 : i32} : (tensor<5x1x4x1xf32>) -> tensor<5x1x4x1xf32>
    %cast = tensor.cast %3 : tensor<9xi8> to tensor<*xi8>
    %cast_0 = tensor.cast %5 : tensor<5x1x4x1xf32> to tensor<*xf32>
    call @printMemrefI8(%cast) : (tensor<*xi8>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}

