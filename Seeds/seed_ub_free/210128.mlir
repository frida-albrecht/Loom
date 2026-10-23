module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-37> : tensor<8x6x9xi16>}> : () -> tensor<8x6x9xi16>
    %1 = "tosa.const"() <{values = dense<105> : tensor<3x2xi64>}> : () -> tensor<3x2xi64>
    %2 = tosa.const_shape  {values = dense<0> : tensor<6xindex>} : () -> !tosa.shape<6>
    %3 = "tosa.const"() <{values = dense<0> : tensor<1xi16>}> : () -> tensor<1xi16>
    %4 = tosa.pad %0, %2, %3 : (tensor<8x6x9xi16>, !tosa.shape<6>, tensor<1xi16>) -> tensor<8x6x9xi16>
    %5 = tosa.bitwise_not %4 : (tensor<8x6x9xi16>) -> tensor<8x6x9xi16>
    %6 = tosa.add %5, %4 : (tensor<8x6x9xi16>, tensor<8x6x9xi16>) -> tensor<8x6x9xi16>
    %7 = tosa.bitwise_and %6, %5 : (tensor<8x6x9xi16>, tensor<8x6x9xi16>) -> tensor<8x6x9xi16>
    %8 = tosa.clamp %7 {max_val = 120 : i16, min_val = -3 : i16} : (tensor<8x6x9xi16>) -> tensor<8x6x9xi16>
    %9 = tosa.identity %8 : (tensor<8x6x9xi16>) -> tensor<8x6x9xi16>
    %10 = tosa.reverse %9 {axis = 2 : i32} : (tensor<8x6x9xi16>) -> tensor<8x6x9xi16>
    %11 = tosa.const_shape  {values = dense<[3, 2, 3]> : tensor<3xindex>} : () -> !tosa.shape<3>
    %12 = tosa.tile %10, %11 : (tensor<8x6x9xi16>, !tosa.shape<3>) -> tensor<24x12x27xi16>
    %cast = tensor.cast %12 : tensor<24x12x27xi16> to tensor<*xi16>
    call @printMemrefI16(%cast) : (tensor<*xi16>) -> ()
    return
  }
}

