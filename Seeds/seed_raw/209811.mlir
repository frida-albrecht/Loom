module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-7> : tensor<10xi8>}> : () -> tensor<10xi8>
    %1 = tosa.const_shape  {values = dense<3> : tensor<1xindex>} : () -> !tosa.shape<1>
    %2 = tosa.tile %0, %1 : (tensor<10xi8>, !tosa.shape<1>) -> tensor<30xi8>
    %cast = tensor.cast %2 : tensor<30xi8> to tensor<*xi8>
    call @printMemrefI8(%cast) : (tensor<*xi8>) -> ()
    return
  }
}

