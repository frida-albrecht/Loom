module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-3> : tensor<7x4xi8>}> : () -> tensor<7x4xi8>
    %1 = tosa.const_shape  {values = dense<[3, 1]> : tensor<2xindex>} : () -> !tosa.shape<2>
    %2 = tosa.tile %0, %1 : (tensor<7x4xi8>, !tosa.shape<2>) -> tensor<21x4xi8>
    %cast = tensor.cast %2 : tensor<21x4xi8> to tensor<*xi8>
    call @printMemrefI8(%cast) : (tensor<*xi8>) -> ()
    return
  }
}

